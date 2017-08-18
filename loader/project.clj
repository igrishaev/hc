(defproject highloadcup "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}

  :dependencies [[org.clojure/clojure "1.9.0-alpha17"]
                 [cheshire "5.7.1"]
                 [clj-http "3.5.0"]]

  :main ^:skip-aot highloadcup.core

  :target-path "target/%s"

  :uberjar-name "loader.jar"

  :profiles {:uberjar {:aot :all}})
