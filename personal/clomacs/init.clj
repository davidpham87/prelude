(import [java.net ServerSocket]
        [java.io File]
        [java.lang ProcessBuilder$Redirect])

(require '[babashka.deps :as deps])
(require '[babashka.classpath :refer (get-classpath)])
(require '[babashka.wait :as wait])
(require '[clojure.edn :as edn])

(deps/add-deps (edn/read-string (slurp "deps.edn")))

(def port (or (edn/read-string (first *command-line-args*)) 1659))

(let [nrepl-port (with-open [sock (ServerSocket. port)] (.getLocalPort sock))
      cp (get-classpath)
      pb (doto (ProcessBuilder. (into ["bb" "--nrepl-server" (str nrepl-port)
                                       "--classpath" cp]))
           (.redirectOutput ProcessBuilder$Redirect/INHERIT))
      proc (.start pb)]
  (wait/wait-for-port "localhost" nrepl-port)
  (spit ".nrepl-port" nrepl-port)
  (.deleteOnExit (File. ".nrepl-port"))
  (.waitFor proc))
