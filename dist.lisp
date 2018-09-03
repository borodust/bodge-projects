(cl:in-package :cl-user)

(ql:quickload :quickdist)

(defun extract-arguments ()
  (uiop:command-line-arguments))

(destructuring-bind (dist-name tar projects-dir dists-dir &rest args)
    (extract-arguments)
  (declare (ignore args))
  (let ((quickdist:*gnutar* tar))
    (quickdist:quickdist :name dist-name
                         :base-url "http://bodge.borodust.org/dist/"
                         :projects-dir projects-dir
                         :dists-dir dists-dir)))
