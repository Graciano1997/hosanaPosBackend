# Hosanna Sale Point – API Backend

**Hosanna Sale Point** is a modern, efficient Sales Point (POS) system designed to manage product sales, transactions, and inventory with ease. This repository contains the **API backend**, built with **Ruby on Rails** and powered by **PostgreSQL** for robust data management. The frontend, developed in **React**, is maintained in a [separate repository](https://github.com/Graciano1997/hosannaPosFront.git).


## 🧰 Tech Stack

- **Ruby on Rails** – RESTful API backend
- **PostgreSQL** – Relational database
- **CORS** – To allow cross-origin requests from the React frontend.
---

## 🚀 Live 
- [visit hosannaBackendApi](https://hosanaposbackendapi.onrender.com/)

- [visit hosannaPosFront](https://hosanna-pos-front.vercel.app/)


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
```

🔗 Frontend Repository

The frontend built with React is available at:

[➡️ Hosanna Sale Point – Frontend](https://github.com/Graciano1997/hosannaPosFront.git)


🧪 Running Tests

```bash
bundle exec rspec
```

👨‍💻 Contributing

    Fork the repo

    Create your feature branch (git checkout -b feature/your-feature)

    Commit your changes (git commit -am 'Add feature')

    Push to the branch (git push origin feature/your-feature)

    Open a Pull Request

✨ Author

Graciano Henrique
[LinkedIn](https://www.linkedin.com/in/gracianohenrique/) | [Github](https://github.com/Graciano1997/)

🙏 Acknowledgments

- Ruby on Rails for the powerful framework.
- PostgreSQL for reliable data storage.
- The open-source community 💛

📄 License

This project is [MIT](./LICENSE) licensed.
