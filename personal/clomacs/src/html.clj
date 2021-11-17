(ns html
  (:require
   [clojure.pprint]
   [babashka.pods :as pods]
   [clojure.walk :as walk]
   [clojure.string :as str]))

(pods/load-pod "bootleg")
(require '[pod.retrogradeorbit.bootleg.utils :refer [convert-to]])

(defn pretty-format [x]
  (with-out-str (clojure.pprint/pprint x)))

(def html->hiccup
  #(->
    (str/trim %)
    str/trim-newline
    (convert-to :hiccup)
    (as-> $
        (walk/postwalk
         (fn [node] (cond
                      (string? node) (when-not (str/blank? node) node)
                      (vector? node) (filterv some? node)
                      :else          node)) $))
    pretty-format))
