#|
  This file is a part of Clack package.
  URL: http://github.com/fukamachi/clack
  Copyright (c) 2011 Eitaro Fukamachi <e.arrows@gmail.com>

  Clack is freely distributable under the LLGPL License.
|#

(in-package :cl-user)
(defpackage clack.handler
  (:use :cl)
  (:import-from :clack.file-watcher
                :stop-watching)
  (:import-from :clack.util
                :find-handler))
(in-package :clack.handler)

(cl-syntax:use-syntax :annot)

@export
(defclass <handler> ()
     ((server-name :type keyword
                   :initarg :server-name
                   :accessor server-name)
      (acceptor :initarg :acceptor
                :accessor acceptor)))

@export
(defgeneric stop (handler)
  (:documentation
   "Stop the Clack server. Currently only works with Hunchentoot.")
  (:method ((this <handler>))
    (let ((handler-package (find-handler (server-name this))))
      (stop-watching this)
      (funcall (intern (string '#:stop) handler-package) (acceptor this)))))

(doc:start)

@doc:NAME "
Clack.Handler - Class for Handler
"

@doc:AUTHOR "
* Eitaro Fukamachi (e.arrows@gmail.com)
"
