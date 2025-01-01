;; -*- lexical-binding: t; -*-

;; Speed up startup with a garbage collector tweak. Check https://www.reddit.com/r/emacs/comments/ofhket/further_boost_start_up_time_with_a_simple_tweak/
(setq gc-cons-threshold 64000000
      gc-cons-percentage 0.6)

;; Disable some UI elements
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq inhibit-startup-screen t)

;; Set font size
(set-face-attribute 'default nil :height 160)

;; Maximize screen frame
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Allow resizing the Emacs frame by individual pixels.
(setq frame-resize-pixelwise t)
;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)



(setq package-enable-at-startup t)
