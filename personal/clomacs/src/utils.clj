(ns utils
  (:require [clojure.edn :as edn]))

(defn lein->deps [s]
  (let [pretty-format #(with-out-str (clojure.pprint/pprint %))]
    (->>
     (for [[p v] (edn/read-string s)] [p {:mvn/version v}])
     (into {})
     pretty-format)))
