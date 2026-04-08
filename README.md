# GA4GH Registry

A RESTful Spring Boot application for registering and discovering implementations of GA4GH Cloud APIs — DRS, WES, TES, and TRS.

## Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/service-info` | Registry service metadata |
| GET | `/api/standards` | All registered standards |
| GET | `/api/standards/{id}` | Single standard by ID |
| GET | `/api/services` | All service implementations |
| GET | `/api/services/{id}` | Single service by ID |
| POST | `/api/services` | Register a new service |
| GET | `/api/deployments` | All deployment implementations |
| GET | `/api/deployments/{id}` | Single deployment by ID |
| POST | `/api/deployments` | Register a new deployment |
| GET | `/api/organisations` | All organisations |
| GET | `/api/organisations/{id}` | Single organisation by ID |
| POST | `/api/organisations` | Register a new organisation |

Swagger UI is available at `/swagger-ui.html`.

## Tech Stack

- Java 21 + Spring Boot 3.x
- PostgreSQL + Flyway migrations
- Docker / AWS ECS EC2
- AWS RDS (PostgreSQL)
- GitHub Actions CI/CD

## Local Development

### Prerequisites
- Java 21
- Docker & Docker Compose

### Run locally

```bash
# Start Postgres
docker run --name ga4gh-db \
  -e POSTGRES_DB=ga4gh_registry \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 -d postgres:15

# Run the application
./gradlew bootRun
```

The application will be available at `http://localhost:8080`.
The UI is served at `http://localhost:8080/index.html`.

### Run tests

```bash
./gradlew test
```

## GitHub Actions Secrets Required

| Secret | Description |
|--------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS IAM access key |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM secret key |
| `DB_PASSWORD` | RDS PostgreSQL password |

## Project Structure

```
src/
├── main/
│   ├── java/org/ga4gh/registry/
│   │   ├── controller/       # REST controllers (5 endpoints)
│   │   ├── service/          # Business logic
│   │   ├── repository/       # Spring Data JPA repositories
│   │   ├── model/
│   │   │   ├── entity/       # JPA entities
│   │   │   ├── dto/          # Request/response DTOs
│   │   │   └── enums/        # ImplementationType enum
│   │   ├── config/           # Mapper, CORS, properties
│   │   └── exception/        # Global error handling
│   └── resources/
│       ├── db/migration/     # Flyway SQL migrations
│       ├── static/           # Single page UI (index.html)
│       └── application.yml
├── test/
│   └── java/org/ga4gh/registry/
│       ├── controller/       # Integration tests
│       └── service/          # Unit tests
infra/
└── cloudformation-template.yaml   # ECS EC2 + RDS stack
.github/
└── workflows/
    └── deploy.yml            # CI/CD pipeline
```
