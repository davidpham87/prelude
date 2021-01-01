(ns jetdotter.core
  (:require
   [cheshire.core :as j]
   [clj-yaml.core :as yaml]
   [clojure.edn]
   [clojure.java.io :refer (input-stream)]
   [clojure.pprint]
   [clojure.string :as str]
   [clojure.tools.cli :refer (parse-opts)]
   [clojure.walk :as walk]
   [cognitect.transit :as t])
  (:import java.io.ByteArrayOutputStream))

(def data-format #{:json :yml :edn :yaml :transit})

(def cli-opts
  [["-f" "--from FROM" "Source Format. Only necessary for transit format."
    :parse-fn keyword]
   ["-t" "--to TO" (format "Target Format. One of %s."
                           (str/join ", " (map name data-format)))
    :default :edn
    :parse-fn keyword
    :validate [data-format]]
   ["-p" "--pretty" "Pretty string output"
    :default true]
   ["-h" "--help" "Show this help"]])

(defn extension [filename]
  (keyword (last (str/split filename #"\."))))

(def vectorify
  "clj-yaml.core/parse-string returns lists instead of vectors"
  (partial walk/postwalk #(cond-> % (sequential? %) vec)))

(defn convert-extension [filename source target]
  (let [filename-parts (str/split filename #"\.")
        new-ext (if  (= target :transit) :transit.json target)
        n-drop
        (if (and (= source :transit)
                 (= (last (butlast filename-parts)) "transit"))
          2 1)]
    (str
     (str/join "." (drop-last n-drop filename-parts ))
     "." (name new-ext))))

(defn parse
  ([s type]
   (case type
     :transit (t/read (t/reader (input-stream (.getBytes s "UTF-8")) :json))
     :yml (vectorify (yaml/parse-string s))
     :yaml (parse s :yml)
     :json (j/decode s keyword)
     :edn (clojure.edn/read-string s)
     identity)))

(defn generate
  ([data type] (generate data type true))
  ([data type pretty?]
   (case type
     :transit (let [baos (ByteArrayOutputStream. 4096)
                    writer (t/writer baos (if pretty? :json :json-verbose))
                    _ (t/write writer data)]
                (String. (.toByteArray baos)))
     :yml (yaml/generate-string data)
     :yaml (generate data :yml)
     :json (j/encode data {:pretty true})
     :edn (if pretty? (with-out-str (clojure.pprint/pprint data)) (str data))
     identity)))

(defn convert [s from to]
  (-> s (parse from) (generate to)))

(defn keywordize-keys [s]
  (let [kw-keys
        (fn [m]
          (let [f (fn [[k v]]
                    (if (or (string? k) (symbol? k))
                      [(keyword k) v] [k v]))]
            (walk/postwalk (fn [x] (if (map? x) (into {} (map f x)) x)) m)))]
    (-> s (parse :edn)
        kw-keys
        (generate :edn))))

(defn -main [& args]
  (let [opts (parse-opts args cli-opts)]
    (when (get-in opts [:options :help])
      (println "Data to Data Conversion")
      (println (:summary opts)))
    (doseq [filename (get opts :arguments)]
      (let [source-format (or (get-in opts [:options :from]) (extension filename))
            target-format (get-in opts [:options :to])
            output-filename (convert-extension filename source-format target-format)]
        (println (format "Converting %s to %s" filename output-filename))
        (-> (slurp filename)
            (parse source-format)
            (generate target-format (get-in opts [:options :pretty]))
            (as-> $ (spit output-filename $)))))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))

(comment
  (parse (generate {:a 3} :transit) :transit)
  (parse (generate {:a 3} :json) :json)
  (parse (generate {:a 3} :yaml) :yaml)
  (parse (generate {:a 3} :edn) :edn)
  (def s "[\"^ \",\"~:a\",3,\"~:b\",[1,2,3,4],\"c\",\"~$a\",\"~:d/k\",[\"~#set\",[1,3,2]]]")
  (t/read (t/reader (input-stream (.getBytes s "UTF-8")) :json))
  (keywordize-keys "{a 2 b 3}")
  )
