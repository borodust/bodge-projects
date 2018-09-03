(cl:in-package :cl-user)

(load (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname)))

(ql:quickload :quickdist)

(defun extract-arguments ()
  (uiop:command-line-arguments))

(destructuring-bind (dist-name tar projects-dir dists-dir &rest args)
    (extract-arguments)
  (declare (ignore args))
  (format t "~&DIST NAME: ~A~&TAR: ~A~&PROJECT DIR: ~A~&DIST DIR: ~A"
          dist-name tar projects-dir dists-dir)
  (let ((quickdist:*gnutar* tar))
    (quickdist:quickdist :name dist-name
                         :base-url "http://bodge.borodust.org/dist/"
                         :projects-dir projects-dir
                         :dists-dir dists-dir)))
