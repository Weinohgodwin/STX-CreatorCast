
;; STX-CreatorCast : Decentralized Video Streaming Platform
;; Version: 1.0.2
;; Description: Smart contract for managing decentralized video content, subscriptions, and revenue distribution

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Constants and Error Codes ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-constant contract-owner tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-NOT-FOUND (err u101))
(define-constant ERR-ALREADY-EXISTS (err u102))
(define-constant ERR-INVALID-PARAMS (err u103))
(define-constant ERR-INSUFFICIENT-FUNDS (err u104))
(define-constant ERR-CONTRACT-PAUSED (err u105))

;;;;;;;;;;;;;;;;;;
;; Data Storage ;;
;;;;;;;;;;;;;;;;;;

;; Platform State
(define-data-var contract-paused bool false)
(define-data-var platform-fee uint u50) ;; 5% represented as 50/1000
(define-data-var next-video-id uint u0)

;; Access Control Maps
(define-map administrators principal bool)
(define-map content-creators principal bool)
(define-map premium-subscribers 
    principal 
    { subscription-expires: uint }
)

;; Content Storage
(define-map videos 
    { video-id: uint }
    {
        creator: principal,
        title: (string-utf8 256),
        description: (string-utf8 1024),
        content-hash: (buff 32),
        price: uint,
        created-at: uint,
        views: uint,
        revenue: uint,
        is-active: bool
    }
)

;; Revenue Tracking
(define-map creator-revenue principal uint)
(define-map platform-revenue (string-ascii 10) uint)

;;;;;;;;;;;;;;;;
;; Governance ;;
;;;;;;;;;;;;;;;;

;; Proposal tracking
(define-map governance-proposals
    uint 
    {
        title: (string-utf8 256),
        description: (string-utf8 1024),
        proposer: principal,
        votes-for: uint,
        votes-against: uint,
        end-height: uint,
        executed: bool
    }
)

;;;;;;;;;;;;;;;;;;;;
;; Authorization ;;
;;;;;;;;;;;;;;;;;;;;

(define-private (is-admin)
    (default-to false (map-get? administrators tx-sender)))

(define-private (is-creator)
    (default-to false (map-get? content-creators tx-sender)))

(define-private (is-contract-owner)
    (is-eq tx-sender contract-owner))

(define-private (check-admin)
    (ok (asserts! (is-admin) ERR-NOT-AUTHORIZED)))

;;;;;;;;;;;;;;;;;;;;
;; Admin Functions ;;
;;;;;;;;;;;;;;;;;;;;

(define-public (set-platform-fee (new-fee uint))
    (begin
        (try! (check-admin))
        (asserts! (<= new-fee u100) ERR-INVALID-PARAMS)
        (ok (var-set platform-fee new-fee))))
