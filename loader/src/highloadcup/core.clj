(ns highloadcup.core
  (:gen-class)
  (:require [clj-http.client :as client]
            [clojure.java.io :as io]
            [clojure.string :as s]
            [cheshire.core :as json]))

(def cm
  (clj-http.conn-mgr/make-reusable-conn-manager
   {:timeout 10 :threads 16}))

(def default-params
  {:content-type :json
   :as :json
   :connection-manager cm
   :throw-exceptions true})

(defn read-zip [path]
  (let [zip (java.util.zip.ZipFile. path)
        entries (-> zip .entries enumeration-seq)]
    (for [e entries
          :when (-> e .getName (s/ends-with? ".json"))]
      (.getInputStream zip e))))

(defn read-stream [stream]
  (json/parse-stream (io/reader stream) true))

(defn get-entity [data]
  (-> data keys first))

(defn load-data [entity items]
  (println entity)
  (doseq [item items]
    (let [url (format "http://127.0.0.1/%s/new" (name entity))
          params (assoc default-params :form-params item)]
      (client/post url params))))

(defn load-db [path]
  (doseq [stream (read-zip path)]
    (let [data (read-stream stream)
          entity (get-entity data)
          items (get data entity)]
      (load-data entity items))))

(defn -main
  [& args]
  (load-db "tmp/data/data.zip"))
