# Hosanna Sale Point – API Backend

**Hosanna Sale Point** is a modern, efficient Sales Point (POS) system designed to manage product sales, transactions, and inventory with ease. This repository contains the **API backend**, built with **Ruby on Rails** and powered by **PostgreSQL** for robust data management. The frontend, developed in **React**, is maintained in a [separate repository](#frontend-repository-link).
---

## 🧰 Tech Stack

- **Ruby on Rails** – RESTful API backend
- **PostgreSQL** – Relational database
- **CORS** – To allow cross-origin requests from the React frontend
---

## 🚀 Getting Started

### Prerequisites

- Ruby >= 3.0
- Rails >= 7.0
- PostgreSQL
- Node.js

### Setup Instructions

1. **Clone the repository**

```bash
git clone https://github.com/Graciano1997/hosanaPosBackend.git

cd hosanaPosBackend

bundle install

rails db:create db:migrate db:seed

rails server

bundle exec rspec
```

🙏 Acknowledgments

- Ruby on Rails for the powerful framework
- PostgreSQL for reliable data storage
- The open-source community 💛
