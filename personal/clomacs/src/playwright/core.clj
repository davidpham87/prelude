(ns playwright.core
  (:require
   [clojure.pprint]
   [clojure.string :as str]))

(defn remove-ending-semi-colon [s]
  (str/replace s #";$" ""))

(defn replace-comment [s]
  (str/replace s #"^([ ]*)//" ";;"))

(defn remove-await [s]
  (str/replace s #"^([ ]*)await([ ])*" ""))

(defn js-quote->cl-string [s]
  (-> (str/replace s "\"" "\\\"")
      (str/replace "'" "\"")))

(defn find-method [s]
  (str/replace (re-find #"^[^\(]+" s) #"^page\." ""))

(defn find-methods [s]
  (vec (drop 1 (str/split s #"\." ))))

(defn swap-paren-position [s]
  (let [method-name (re-find #"^[^\(]+" s)]
    (-> (str "(." method-name " " (str/replace s (re-pattern (str"^" method-name "\\(")) ""))
        (str/replace #" \)" ")"))))

(defn parse-page-method [s]
  (if (str/starts-with? s "page")
    (let [method (find-method s)
          methods (mapv (comp swap-paren-position js-quote->cl-string) (find-methods s))]

     (-> s
         (as-> $ (clojure.pprint/cl-format nil "(-> page ~A)" (str/join " " methods)))))
    s))

(defn expect-page-url? [s]
  (str/starts-with? s "expect(page).toHaveURL"))

(defn code->clj [s]
  (let [lines (str/split-lines s)]
    (->> (into [] (comp
                   (map #(-> %
                             replace-comment
                             remove-await
                             remove-ending-semi-colon
                             parse-page-method))
                   (remove expect-page-url?))
               lines)
         (str/join "\n"))))

(comment
  (let [s "
  await page.locator('button[role=\"tab\"]:has-text(\"Style\")').click();
  await page.locator('button[role=\"tab\"]:has-text(\"Style\")').first().click();
"]
    #_(println (str/join "\n" (code->clj s)))
    (println (code->clj s))
    )

  (clojure.pprint/cl-format nil "(.click page ~A)" "hello")
  (clojure.pprint/cl-format nil "(.~A page ~A)" "hello" "world"))
