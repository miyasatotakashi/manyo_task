erDiagram
users ||--|{ tasks: ""
tasks ||--|{ labels: ""

users {
  string name
  string email
  string password_digest
}

tasks {
  string title
  string content
}

labels {
  string label
}