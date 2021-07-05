(ns utils
  (:require
   [clojure.edn :as edn]
   [clojure.pprint]
   [clojure.string :as str]))

(defn pretty-format [x]
  (with-out-str (clojure.pprint/pprint x)))

(defn lein->deps [s]
  (->>
   (for [[p v] (edn/read-string s)] [p {:mvn/version v}])
   (into {})
   pretty-format))

(defn sym->map [s]
  (let [xs (-> s
               (str/split #" ")
               sort)]
    (->
     (zipmap (map keyword xs) (map symbol xs))
     pretty-format)))
