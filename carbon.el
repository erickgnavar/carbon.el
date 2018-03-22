;;; carbon.el --- Send buffer or region code to carbon.now.sh to generate an image.

;; Copyright © 2018 Erick Navarro
;; Author: Erick Navarro <erick@navarro.io>
;; URL: https://github.com/erickgnavar/carbon.el
;; Version: 0.1.0

;;; Commentary:
;; Just send the selected code to carbon website

;;; Code:

(require 'url)

(defconst carbon--url "https://carbon.now.sh")

(defun carbon--prepare-url (code)
  "Given a CODE builds a url to be opened in browser."
  (url-encode-url (concat (format "%s?l=%s&code=%s" carbon--url (downcase mode-name) code))))

(defun carbon--send-code (code)
  "Send CODE to api."
  (browse-url (carbon--prepare-url code)))

(defun carbon-send-buffer ()
  "Send buffer content to carbon."
  (interactive)
  (carbon--send-code (buffer-substring-no-properties (point-min) (point-max))))

(defun carbon-send-region ()
  "Send buffer content to carbon."
  (interactive)
  (if (region-active-p)
      (carbon--send-code (buffer-substring-no-properties (region-beginning) (region-end)))
    (message "There is no active region.")))

(provide 'carbon)

;;; carbon.el ends here
