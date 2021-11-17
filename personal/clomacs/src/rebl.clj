(ns rebl
  (:require [portal.api]
            [portal.client.jvm]))

(defn portal []
  (portal.api/open {:portal.launcher/port 53755}))

(def submit portal.client.jvm/submit)

(comment
  #_(portal.api/open)
  )
