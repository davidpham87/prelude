(ns hello
  (:require
   [clojure.edn :as edn]
   [clojure.string :as str]))

(defn main
  ([] (main ["Hello this is a test" :emacs]))
  ([s]
   (let [m (into {} (map vec (partition 2 s)))]
     m)))

(defn rand-int
  ([] [(clojure.core/rand-int 10)])
  ([x] [(clojure.core/rand-int x)])
  ([f x] [(clojure.core/rand-int x) f])
  ([f x & _] [(clojure.core/rand-int (first x)) x _]))

(defn split [s re] (str/split s (re-pattern re)))

(comment
  (into {} (map vec (partition 2 '(1 2 3 4))))
  (rand-int )
  )
