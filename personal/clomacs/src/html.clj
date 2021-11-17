(ns html
  (:require
   [babashka.pods :as pods]))

(pods/load-pod "bootleg")
(require '[pod.retrogradeorbit.bootleg.utils :refer [convert-to]])
(def html->hiccup #(convert-to % :hiccup))
