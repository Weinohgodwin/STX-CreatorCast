

# STX-CreatorCast - Decentralized Video Streaming Platform - Smart Contract

**Version:** 1.0.2
**Language:** Clarity
**Platform:** Stacks Blockchain

## 📝 Description

This Clarity smart contract powers a **decentralized video streaming platform** where:

* Content creators can upload and monetize their videos.
* Users can purchase videos or subscribe to a premium plan.
* Revenue is automatically distributed to creators and the platform.
* Admins manage platform settings.
* Governance proposals can be created and voted on for protocol upgrades.

---

## 🔐 Key Features

### ✅ Access Control

* **Owner**: Original deployer of the contract, initialized as the first admin.
* **Administrators**: Can manage fees and contract state.
* **Content Creators**: Must register before uploading videos.
* **Premium Subscribers**: Users who pay to access content over time.

### 📦 Video Management

* Upload videos with metadata (`title`, `description`, `content-hash`, `price`)
* View and purchase video content
* Track view count and revenue per video

### 💸 Payments & Revenue

* **Video Purchases**: STX transferred from users to creators
* **Premium Subscription**: 10 STX per subscription period
* **Platform Fee**: Configurable percentage (default: 5%)—can be applied later in revenue split logic

### 🛑 Contract Controls

* Admins can **pause/unpause** the contract
* Update the **platform fee** (max 10%)

### 🗳️ Governance (planned)

* Proposals can be created, voted on, and tracked for execution

---

## 📚 Function Overview

### 🔧 Admin Functions

| Function                | Description                              |
| ----------------------- | ---------------------------------------- |
| `set-platform-fee`      | Set platform fee (0–1000, i.e., 0%–100%) |
| `toggle-contract-pause` | Pause/unpause the contract               |
| `add-administrator`     | Add a new admin address                  |

### 🎥 Creator Functions

| Function              | Description                 |
| --------------------- | --------------------------- |
| `register-as-creator` | Register as a video creator |
| `upload-video`        | Upload new video content    |

### 👤 User Functions

| Function            | Description                                |
| ------------------- | ------------------------------------------ |
| `purchase-video`    | Buy a specific video                       |
| `subscribe-premium` | Subscribe for a given duration (in blocks) |

### 🔍 Read-Only Functions

| Function                | Description                                      |
| ----------------------- | ------------------------------------------------ |
| `get-video-details`     | Get full video metadata                          |
| `get-creator-revenue`   | View accumulated revenue for a creator           |
| `is-premium-subscriber` | Check if a user’s premium subscription is active |

---

## ⚙️ Data Structures

* **Videos**:

  ```clojure
  {
    video-id: uint,
    creator: principal,
    title: string-utf8,
    description: string-utf8,
    content-hash: buff,
    price: uint,
    created-at: uint,
    views: uint,
    revenue: uint,
    is-active: bool
  }
  ```

* **Subscribers**:

  ```clojure
  {
    subscription-expires: uint
  }
  ```

---

## 🧪 Error Codes

| Code  | Meaning            |
| ----- | ------------------ |
| `100` | Not Authorized     |
| `101` | Not Found          |
| `102` | Already Exists     |
| `103` | Invalid Parameters |
| `104` | Insufficient Funds |
| `105` | Contract Paused    |

---

## 📌 Deployment Notes

* The contract owner is automatically registered as an administrator on deployment.
* Platform revenue tracking starts with a "total" entry.
* Governance functionality is initialized but not fully implemented for proposal execution.

---

## ✅ Future Enhancements

* Apply platform fee deduction in the `purchase-video` function.
* Add ability to deactivate videos.
* Implement governance proposal execution.
* Refunds or subscription cancellation logic.

---

## 📄 License

MIT or any permissive license of your choice.

---
