# Rails Cookie and Session Security Demo

A small Ruby on Rails 7.1 application for studying how cookie flags and session expiry
affect common session attacks. It has two configurations:

- **Baseline:** Secure, HttpOnly and SameSite off, no session expiry, served over HTTP.
- **Hardened:** Secure, HttpOnly and SameSite=Lax on, 30-minute session expiry, served over HTTPS.

> **Warning:** the baseline configuration is deliberately insecure. Run it only in an
> isolated test environment and never deploy it or expose it to a network you do not control.

## Features
- Login page (`/login`) and a protected page (`/protected`)
- Cookie-based session using Rails' default session store
- Configurable cookie flags and session expiry

## Requirements
- Ruby [3.2 or newer; see `.ruby-version`]
- Rails 7.1
- Bundler
- SQLite [or your database]
- mkcert (for the HTTPS configuration)

## 1. Install Ruby on Rails (Ubuntu / WSL)

1. Update the system and install build tools:
```bash
   sudo apt update
   sudo apt install -y git curl build-essential libssl-dev libreadline-dev \
     zlib1g-dev libyaml-dev libffi-dev libsqlite3-dev sqlite3
```
2. Install Ruby with rbenv:
```bash
   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
   git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
   source ~/.bashrc
   rbenv install [3.2.2]
   rbenv global [3.2.2]
   ruby -v
```
3. Install Rails:
```bash
   gem install bundler
   gem install rails -v 7.1
   rails -v
```

## 2. Get the code and set it up
```bash
git clone https://github.com/UsmanAzmat300/rails-cookie-security-testing.git
cd rails-cookie-security-testing
bundle install
bin/rails db:create db:migrate
[bin/rails db:seed]     # only if your project has a seed file that creates the test user
```

## 3. Run the baseline configuration (HTTP)
```bash
bin/rails server -b 0.0.0.0 -p 3000
```
Open `http://localhost:3000/login`.

## 4. Run the hardened configuration (HTTPS)
1. Install mkcert and create a local certificate (the certificate and key files are
   not included in this repository):
```bash
   sudo apt install -y mkcert
   mkcert -install
   mkcert localhost
```
2. Start the server with TLS (use the file names mkcert created):
```bash
   bin/rails server -b "ssl://0.0.0.0:3000?key=localhost-key.pem&cert=localhost.pem"
```
3. Open `https://localhost:3000/login`.

## Switching configurations
Cookie flags and expiry are set in `[config/initializers/session_store.rb]`:

| Setting | Baseline | Hardened |
|---|---|---|
| `secure` | false | true |
| `httponly` | false | true |
| `same_site` | none | `:lax` |
| `expire_after` | not set | `30.minutes` |

## Test account
Username: `[testuser]`, password: `[see db/seeds.rb]`. For local testing only.

## Project structure
```
app/controllers/    login and protected page logic
app/views/          login and protected page templates
config/initializers/session_store.rb   session cookie settings
config/routes.rb    routes
```

## Troubleshooting
- `bundle install` fails: check `ruby -v` matches `.ruby-version`.
- Browser warns about the certificate: run `mkcert -install` and restart the browser.
- Port 3000 in use: stop the other server or use `-p 3001`.
