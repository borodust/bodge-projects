(cl:in-package :cl-user)

(ql:quickload "quickdist")

(destructuring-bind (tar projects-dir dists-dir) (rest *posix-argv*)
  (let ((quickdist:*gnutar* tar))
    (quickdist:quickdist :name "org.borodust.bodge"
                         :base-url "http://bodge.borodust.org/dist/"
                         :projects-dir projects-dir
                         :dists-dir dists-dir)))
