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

(defn parse-page-method [s]
  (if (str/starts-with? s "page")
    (let [method (find-method s)]
      (-> s
          (str/replace (re-pattern (str "page." method "\\((.+)\\)")) "$1")
          js-quote->cl-string
          (as-> $ (clojure.pprint/cl-format nil "(.~A page ~A)" method $))))
    s))

(defn expect-page-url? [s]
  (str/starts-with? s "expect(page).toHaveURL"))

(defn code->clj [s]
  (let [lines (str/split-lines s)]
    (into [] (comp
              (map #(-> %
                        replace-comment
                        remove-await
                        remove-ending-semi-colon
                        parse-page-method))
              (remove expect-page-url?))
          lines)))

(comment
  (let [s "// Go to http://localhost:8000/
  await page.goto('http://localhost:8000/');
  // Click text=Wealth Management
  await page.click('text=Wealth Management');
  // Click text=Swiss Francs CHF
  await page.click('text=Swiss Francs CHF');
  // Click text=Performance CurrencyUS $Euro €Swiss Francs CHFFund Selection >> p
  await page.click('text=Performance CurrencyUS $Euro €Swiss Francs CHFFund Selection >> p');
  await expect(page).toHaveURL('http://localhost:8000/#/funds');
  // Click [aria-label=\"next page\"]
  await page.click('[aria-label=\"next page\"]');
  // Click text=Vontobel Asia Pacific Equity
  await page.click('text=Vontobel Asia Pacific Equity');
  await expect(page).toHaveURL('http://localhost:8000/#/fund/30102303100_1_10311111_1/overview');
  // Click button[role=\"tab\"]:has-text(\"Insights\")
  await page.click('button[role=\"tab\"]:has-text(\"Insights\")');
  await expect(page).toHaveURL('http://localhost:8000/#/fund/30102303100_1_10311111_1/insights');
  // Click button[role=\"tab\"]:has-text(\"ESG\")
  await page.click('button[role=\"tab\"]:has-text(\"ESG\")');
  await expect(page).toHaveURL('http://localhost:8000/#/fund/30102303100_1_10311111_1/esg');
  // Click button[role=\"tab\"]:has-text(\"Risk\")
  await page.click('button[role=\"tab\"]:has-text(\"Risk\")');
  await expect(page).toHaveURL('http://localhost:8000/#/fund/30102303100_1_10311111_1/analytics');
  // Click button:has-text(\"Selection\")
  await page.click('button:has-text(\"Selection\")');
  await expect(page).toHaveURL('http://localhost:8000/#/funds');"]
    (println (str/join "\n" (code->clj s))))
  (clojure.pprint/cl-format nil "(.click page ~A)" "hello")
  (clojure.pprint/cl-format nil "(.~A page ~A)" "hello" "world")
  (find-method "page.click('text=Swiss Francs CHF')")
  "page.click()"
  "page.goto()")
