(ns rebl
  (:require [portal.api]
            [portal.client.jvm]
            [clojure.edn :as edn]))

(defn portal []
  (portal.api/open {:portal.launcher/port 53755}))

(def submit (comp portal.client.jvm/submit edn/read-string))

(comment
  #_(portal.api/open)
  )
