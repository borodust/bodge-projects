(cl:in-package :cl-user)

(ql:quickload :quickdist)

(defun extract-arguments ()
  (let ((args (reverse *posix-argv*)))
    (setf (cdddr args) nil)
    (nreverse args)))

(destructuring-bind (tar projects-dir dists-dir) (extract-arguments)
  (let ((quickdist:*gnutar* tar))
    (quickdist:quickdist :name "org.borodust.bodge"
                         :base-url "http://bodge.borodust.org/dist/"
                         :projects-dir projects-dir
                         :dists-dir dists-dir)))
