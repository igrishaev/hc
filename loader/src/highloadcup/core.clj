(ns highloadcup.core
  (:gen-class)
  (:require [clj-http.client :as client]
            [clojure.java.io :as io]
            [cheshire.core :as json]))

(defn read-zip [path]
  (let [zip (java.util.zip.ZipFile. path)
        entries (-> zip .entries enumeration-seq)]
    (for [e entries]
      (.getInputStream zip e))))

(defn read-stream [stream]
  (json/parse-stream (io/reader stream) true))

(defn get-entity [data]
  (-> data keys first))

(defn load-data [entity items]
  (doseq [item items]
    (let [id (:id item)
          url (format "http://127.0.0.1/%s/new" (name entity))
          params {:content-type :json
                  :as :json
                  :throw-exceptions true
                  :form-params item}]
      (client/post url params  ))))

(defn load-db [path]
  (doseq [stream (read-zip path)]
    (let [data (read-stream stream)
          entity (get-entity data)
          items (get data entity)]
      (load-data entity items))))

(defn -main
  [& args]
  (load-db "tmp/data/data.zip"))
