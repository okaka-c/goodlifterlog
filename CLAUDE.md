# CLAUDE.md - AI Assistant Guide for PowerLifter's Log

**Last Updated**: 2025-11-26
**Project**: PowerLifter's Log (goodlifterlog)
**Purpose**: Comprehensive guide for AI assistants working with this codebase

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Tech Stack](#tech-stack)
3. [Codebase Structure](#codebase-structure)
4. [Architecture Patterns](#architecture-patterns)
5. [Development Workflow](#development-workflow)
6. [Key Conventions](#key-conventions)
7. [Testing Guidelines](#testing-guidelines)
8. [Common Tasks](#common-tasks)
9. [Important Notes for AI Assistants](#important-notes-for-ai-assistants)

---

## Project Overview

### What is PowerLifter's Log?

PowerLifter's Log is a web application for powerlifting and single bench press competition tracking. It enables athletes to:
- Register competition results with detailed attempt tracking
- View historical performance data
- Visualize progress through charts
- Calculate IPF GL (Goodlift) points automatically
- Compare current performance against previous competitions

**Live URL**: https://www.powerlifterslog.com/

### Domain Context

**Powerlifting** consists of three lifts:
1. Squat (スクワット)
2. Bench Press (ベンチプレス)
3. Deadlift (デッドリフト)

**Single Bench Press** competitions only include the bench press.

Each lift has 3 attempts in competition. The best successful attempt from each lift counts toward the total.

**Equipment Categories**:
- Raw/Classic (ノーギア): Minimal equipment
- Equipped (フルギア): Supportive equipment allowed

**Key Metrics**:
- Total Lifted Weight: Sum of best lifts
- IPF GL Points: Normalized score accounting for body weight and gender

### Cultural Context

**Theme Color Significance**: The primary red color (#fc345c) represents the 25kg competition plate, which is red. This plate is called "赤盤" (red plate) by athletes and symbolizes strength and achievement in the community.

**Language**: Primary language is Japanese. All user-facing content should be in Japanese.

---

## Tech Stack

### Core Technologies

| Category | Technology | Version/Details |
|----------|-----------|-----------------|
| **Language** | Ruby | 3.2.2 |
| **Framework** | Ruby on Rails | 7.0.8+ |
| **Database** | PostgreSQL | Latest (via Docker) |
| **Web Server** | Puma | ~> 5.0 |
| **Containerization** | Docker | docker-compose setup |

### Frontend Stack

| Category | Technology | Purpose |
|----------|-----------|---------|
| **CSS Framework** | TailwindCSS 3.4.3 | Utility-first styling |
| **Component Library** | DaisyUI 4.9.0 | Pre-built UI components |
| **JavaScript Framework** | Hotwire (Turbo + Stimulus) | SPA-like experience |
| **Charts** | Chart.js 4.4.3 + Chartkick 5.0.1 | Data visualization |
| **Bundler** | esbuild 0.20.2 | JavaScript bundling |

### Key Gems

**Authentication & Authorization**:
- `sorcery` - Main authentication framework
  - Submodules: `:reset_password`, `:external` (for LINE OAuth)

**External Integrations**:
- `line-bot-api` - LINE Messaging API integration

**Development Tools**:
- `rubocop` (with rails, rspec, performance, capybara, factory_bot extensions)
- `pry-byebug` - Debugging
- `better_errors` + `binding_of_caller` - Enhanced error pages
- `letter_opener_web` - Email preview in development

**Testing**:
- `rspec-rails` - Testing framework
- `factory_bot_rails` - Test data factories
- `capybara` + `selenium-webdriver` - System testing

**Configuration & Utilities**:
- `config` - Application settings management
- `dotenv-rails` - Environment variable loading
- `rails-i18n` - Rails internationalization
- `enum_help` - Enum translations
- `meta-tags` - SEO and OGP meta tags

---

## Codebase Structure

### Directory Overview

```
goodlifterlog/
├── app/
│   ├── assets/
│   │   ├── builds/              # Compiled CSS/JS output
│   │   ├── config/              # Asset pipeline config
│   │   ├── images/              # Static images
│   │   └── stylesheets/         # Tailwind source files
│   ├── controllers/
│   │   ├── concerns/            # Shared controller logic (empty)
│   │   ├── record/              # Step-form controllers (IMPORTANT)
│   │   └── *.rb                 # Main controllers
│   ├── helpers/                 # View helpers
│   ├── javascript/
│   │   └── controllers/         # Stimulus controllers
│   ├── models/
│   │   ├── concerns/            # Shared model logic (empty)
│   │   ├── record/              # Form objects for validation (IMPORTANT)
│   │   └── *.rb                 # ActiveRecord models
│   ├── queries/                 # Query objects (IMPORTANT)
│   ├── views/
│   │   ├── record/              # Step-form views
│   │   ├── shared/              # Reusable partials
│   │   └── */                   # Feature-specific views
│   └── mailers/                 # Email templates
├── config/
│   ├── credentials/             # Encrypted credentials
│   ├── environments/            # Environment configs
│   ├── initializers/            # App initialization
│   ├── locales/                 # I18n translations (Japanese)
│   │   ├── activemodel/
│   │   ├── activerecord/
│   │   └── view/
│   └── settings/                # Config gem settings
├── db/
│   ├── migrate/                 # Database migrations
│   └── schema.rb                # Current schema
├── spec/
│   ├── factories/               # FactoryBot factories
│   ├── models/                  # Model specs
│   ├── system/                  # Feature/system specs
│   └── support/                 # Test helpers
├── .github/
│   └── workflows/               # CI/CD workflows
├── docker-compose.yml           # Docker orchestration
├── Dockerfile.dev               # Development container
├── Procfile.dev                 # Development processes
└── package.json                 # Node.js dependencies
```

### Key File Locations

| Purpose | Location |
|---------|----------|
| **Routes** | `config/routes.rb` |
| **Database Schema** | `db/schema.rb` |
| **Rubocop Config** | `.rubocop.yml` |
| **Docker Compose** | `docker-compose.yml` |
| **Tailwind Config** | `tailwind.config.js` |
| **Package Config** | `package.json` |
| **CI Workflow** | `.github/workflows/rubyonrails.yml` |
| **Sorcery Config** | `config/initializers/sorcery.rb` |
| **Application Layout** | `app/views/layouts/application.html.erb` |

---

## Architecture Patterns

### Database Schema & Models

#### Core Models and Relationships

```ruby
User (users)
├── has_one :profile
├── has_many :competitions
└── has_many :authentications

Profile (profiles)
└── belongs_to :user

Authentication (authentications)
└── belongs_to :user
    # Stores LINE OAuth data

Competition (competitions)
├── belongs_to :user
└── has_one :competition_record

CompetitionRecord (competition_records)
├── belongs_to :competition
└── has_one :competition_result
    # Stores all 9 attempts (squat/bench/deadlift × 3)

CompetitionResult (competition_results)
└── belongs_to :competition_record
    # Stores calculated results: best lifts, total, IPF points
```

#### Enums (IMPORTANT)

All enums use integer values with symbol keys:

**User**:
- `role`: `{ user: 0, guest: 1 }`

**Profile**:
- `gender`: `{ man: 0, women: 1 }`

**Competition**:
- `competition_type`: `{ official: 0, unofficial: 1 }`
- `gearcategory_type`: `{ raw: 0, equipped: 1 }`
- `participation_status`: `{ participated: 0, scheduled: 1 }`
- `category`: String field (not enum)
- `age_group`: String field (not enum)
- `weight_class`: String field (not enum)

**CompetitionRecord** (9 enums for attempt results):
- `squat_first_attempt_result`: `{ not_attempted: 0, success: 1, failure: 2 }`
- Similar enums for all 9 attempts (squat/bench/deadlift × 3)

### Step-Form Pattern (CRITICAL PATTERN)

The competition record entry uses a 5-step form with a specific architectural pattern:

**Steps**:
1. **Weigh-in** (`Record::WeighInsController`) - Body weight
2. **Squat** (`Record::SquatsController`) - 3 squat attempts
3. **Bench Press** (`Record::BenchPressesController`) - 3 bench press attempts
4. **Deadlift** (`Record::DeadliftsController`) - 3 deadlift attempts
5. **Comment** (`Record::CommentsController`) - Final comment & save

**Key Implementation Details**:
- **Form Objects**: Located in `app/models/record/`
  - Each step has a form object inheriting from `ActiveModel::Model`
  - Validates data WITHOUT persisting to database
  - Example: `Record::WeighIn`, `Record::Squat`, etc.
- **Session Storage**: Form data stored in `session[:competition_record]` between steps
- **Controllers**: Located in `app/controllers/record/`
  - Each controller validates current step
  - On success: stores data in session, redirects to next step
  - On failure: re-renders form with errors
- **Final Persistence**: Only `Record::CommentsController#create` saves to database
- **Transaction Safety**: Uses `ActiveRecord::Base.transaction` to ensure atomicity
- **Result Calculation**: Automatic calculation of best lifts, total, and IPF GL points

**Routes Pattern**:
```ruby
resources :competitions do
  scope module: 'record' do
    resource :weigh_in, only: %i[new create edit update]
    resource :squat, only: %i[new create edit update]
    resource :bench_presse, only: %i[new create edit update]  # Note: 'presse'
    resource :deadlift, only: %i[new create edit update]
    resource :comment, only: %i[new create edit update]
  end
end
```

**When Modifying Step-Form**:
1. Update form object in `app/models/record/`
2. Update controller in `app/controllers/record/`
3. Update view in `app/views/record/`
4. Update I18n keys in `config/locales/activemodel/ja.yml`
5. Test the full flow (all 5 steps)

### Query Object Pattern

Location: `app/queries/`

**Purpose**: Encapsulate complex database queries for chart data and statistics.

**Base Pattern**:
```ruby
class Query
  def self.call(*)
    new(*).call
  end

  def call
    raise NotImplementedError
  end
end
```

**Builder Pattern**:
```ruby
class QueryBuilder
  def initialize(user)
    @user = user
    @relation = user.competitions
                    .joins(competition_record: :competition_result)
                    .where(participation_status: 0)
                    .order(date: :asc)
  end

  def with_competition_type(competition_type)
    @relation = @relation.where(competition_type: competition_type)
    self  # Return self for chaining
  end

  # More chainable methods...
end
```

**Existing Query Classes**:
- `ClassicPowerliftingIpfglpointsQuery`
- `ClassicPowerliftingTotalLiftedWeightQuery`
- `ClassicSingleBenchPressIpfglpointsQuery`
- `ClassicSingleBenchPressLiftedWeightQuery`
- `EquippedPowerliftingIpfglpointsQuery`
- `EquippedPowerliftingTotalLiftedWeightQuery`
- `EquippedSingleBenchPressIpfglpointsQuery`
- `EquippedSingleBenchPressLiftedWeightQuery`

**Naming Convention**: `{Equipment}{Category}{Metric}Query`
- Equipment: `Classic` or `Equipped`
- Category: `Powerlifting` or `SingleBenchPress`
- Metric: `Ipfglpoints` or `TotalLiftedWeight` or `LiftedWeight`

**Usage in Controllers**:
```ruby
@chart_data = ClassicPowerliftingTotalLiftedWeightQuery.call(current_user)
```

### IPF GL Points Calculation

**Location**: `CompetitionResult` model

**Formula**:
```ruby
total_lifted_weight * 100 / (a - b * Math.exp(-c * body_weight))
```

**Coefficients**: Stored in `CompetitionResult::COEFFICIENTS` constant
- Varies by: gender, equipment type, category
- Example structure:
  ```ruby
  {
    man: {
      raw: {
        powerlifting: { a: 1199.72839, b: 1025.18162, c: 0.00921 },
        single_bench_press: { a: 320.98041, b: 281.40258, c: 0.01008 }
      },
      equipped: { ... }
    },
    women: { ... }
  }
  ```

**Calculation Trigger**: Automatically calculated when `CompetitionRecord` is saved in the final step.

---

## Development Workflow

### Initial Setup

```bash
# 1. Clone repository
git clone <repository-url>
cd goodlifterlog

# 2. Copy environment file (if needed)
cp .env.example .env  # Edit with your credentials

# 3. Start Docker containers
docker-compose up -d

# 4. Setup database
docker-compose exec web bundle exec rails db:create db:migrate

# 5. (Optional) Load seed data
docker-compose exec web bundle exec rails db:seed

# 6. Access application
# http://localhost:3000
```

### Common Docker Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f web

# Run Rails console
docker-compose exec web bundle exec rails console

# Run migrations
docker-compose exec web bundle exec rails db:migrate

# Run tests
docker-compose exec web bundle exec rspec

# Run Rubocop
docker-compose exec web bundle exec rubocop

# Install gems
docker-compose exec web bundle install

# Install npm packages
docker-compose exec web yarn install

# Rebuild containers (after Gemfile/package.json changes)
docker-compose up -d --build
```

### Development Processes

The application uses `Procfile.dev` for local development:

```bash
# Option 1: Using foreman (if installed)
foreman start -f Procfile.dev

# Option 2: Run processes separately
# Terminal 1: Rails server
bin/rails server

# Terminal 2: JavaScript watch
yarn build --watch

# Terminal 3: CSS watch
yarn build:css --watch
```

### Asset Pipeline

**JavaScript**:
- Source: `app/javascript/`
- Build: `yarn build`
- Watch: `yarn build --watch`
- Output: `app/assets/builds/`

**CSS (Tailwind)**:
- Source: `app/assets/stylesheets/application.tailwind.css`
- Build: `yarn build:css`
- Watch: `yarn build:css --watch`
- Output: `app/assets/builds/application.css`

**Important**: After modifying Tailwind classes or JavaScript, run the appropriate build command.

### Database Operations

```bash
# Create migration
docker-compose exec web bundle exec rails generate migration MigrationName

# Run migrations
docker-compose exec web bundle exec rails db:migrate

# Rollback last migration
docker-compose exec web bundle exec rails db:rollback

# Reset database (DESTRUCTIVE)
docker-compose exec web bundle exec rails db:reset

# Check schema
cat db/schema.rb
```

---

## Key Conventions

### File Naming

| Type | Convention | Example |
|------|-----------|---------|
| **Models** | Singular PascalCase | `User`, `Competition`, `CompetitionRecord` |
| **Controllers** | Plural PascalCase + `Controller` | `CompetitionsController`, `Record::SquatsController` |
| **Views** | snake_case | `new.html.erb`, `edit.html.erb` |
| **Partials** | `_` prefix + snake_case | `_form.html.erb`, `_competition.html.erb` |
| **Helpers** | Plural PascalCase + `Helper` | `ApplicationHelper`, `CompetitionsHelper` |
| **Query Objects** | PascalCase + `Query` | `ClassicPowerliftingIpfglpointsQuery` |
| **Form Objects** | PascalCase under namespace | `Record::WeighIn`, `Record::Squat` |

### Code Organization

**Controllers**:
- Keep actions RESTful when possible
- Use `before_action` for setup
- Delegate complex queries to Query objects
- Delegate business logic to models/services

**Models**:
- Keep models focused on domain logic
- Use validations extensively
- Define enums at top of class
- Use associations clearly

**Views**:
- Extract repeated markup to partials
- Use helpers for complex view logic
- Keep views thin (no business logic)
- Use I18n for all user-facing text

**Queries**:
- One query class per specific query need
- Use builder pattern for complex queries
- Keep queries chainable
- Return ActiveRecord relations when possible

### I18n (Internationalization)

**Primary Language**: Japanese (ja)

**File Organization**:
- `config/locales/activerecord/` - Model translations
- `config/locales/activemodel/` - Form object translations
- `config/locales/view/` - View-specific translations
- Enums: `config/locales/activerecord/enums.ja.yml`

**Enum Translation Pattern**:
```yaml
# config/locales/activerecord/enums.ja.yml
activerecord:
  enums:
    competition:
      competition_type:
        official: '公式'
        unofficial: '非公式'
```

**View Translation Pattern**:
```yaml
# config/locales/view/competitions/index.ja.yml
ja:
  competitions:
    index:
      title: '大会一覧'
```

**Usage in Views**:
```erb
<%= t('.title') %>  # Scoped to current view
<%= Competition.human_attribute_name(:name) %>  # Model attribute
<%= @competition.competition_type_i18n %>  # Enum value (via enum_help)
```

### Tailwind & DaisyUI

**Theme**: `mytheme` (custom theme based on red powerlifting plate)

**Common Component Classes**:
- Buttons: `btn`, `btn-primary`, `btn-secondary`
- Cards: `card`, `card-body`, `card-title`
- Navigation: `drawer`, `navbar`, `btm-nav`
- Forms: `form-control`, `label`, `input`, `textarea`, `select`
- Alerts: `alert`, `alert-success`, `alert-error`

**Custom Colors**:
```javascript
primary: "#fc345c"      // Red (25kg plate)
secondary: "#FF823B"
accent: "#49BEB7"
```

**Responsive Design**:
- Mobile-first approach
- Use Tailwind responsive prefixes: `sm:`, `md:`, `lg:`
- Drawer navigation for mobile
- Bottom navigation bar for mobile

### Flash Messages

**Types**: `:success`, `:danger`, `:warning`

**Usage**:
```ruby
redirect_to path, success: 'メッセージ'
redirect_to path, danger: 'エラーメッセージ'
```

**Rendering**: Handled in `app/views/layouts/application.html.erb` with auto-dismiss.

### Guest User Pattern

**Purpose**: Allow users to explore the app without registration.

**Implementation**:
- Guest role: `User.role = :guest`
- Restriction: Cannot create, edit, or delete (defined in `ApplicationController#restrict_guest_user_actions`)
- Login: `GuestSessionsController#create`

**Important**: Always check for guest users before allowing mutations.

---

## Testing Guidelines

### RSpec Setup

**Configuration**:
- `spec/rails_helper.rb` - Rails-specific config
- `spec/spec_helper.rb` - General RSpec config
- `spec/support/` - Shared test helpers

**Key Features**:
- FactoryBot integrated (use `create`, `build`, `build_stubbed`)
- Capybara for system tests
- Selenium with headless Chrome
- Login macros for authenticated tests

### Test Organization

```
spec/
├── factories/          # Test data factories
├── models/            # Model unit tests
├── system/            # Feature/integration tests
└── support/
    ├── capybara.rb    # Browser test config
    └── login_macros.rb # Authentication helpers
```

### FactoryBot Patterns

**Location**: `spec/factories/`

**Usage**:
```ruby
# Create and persist
user = create(:user)

# Build without persisting
user = build(:user)

# Create with associations
competition = create(:competition, user: user)

# Override attributes
user = create(:user, name: 'カスタム名')
```

**Associations**:
- User factory automatically creates profile (via `after(:create)`)
- Competition factory requires user

### System Test Patterns

**Login Helper**:
```ruby
# spec/support/login_macros.rb
module LoginMacros
  def login(user)
    # ... handles LINE OAuth stubbing
  end
end

# In system tests
RSpec.describe 'Feature', type: :system do
  let(:user) { create(:user) }

  it 'does something' do
    login(user)
    # ... test authenticated flow
  end
end
```

**Capybara Configuration**:
- Headless Chrome for local development
- Remote Chrome for CI environment
- Screenshots on failure (stored in `tmp/capybara/`)

### Running Tests

```bash
# All tests
docker-compose exec web bundle exec rspec

# Specific file
docker-compose exec web bundle exec rspec spec/models/competition_spec.rb

# Specific line
docker-compose exec web bundle exec rspec spec/models/competition_spec.rb:10

# By type
docker-compose exec web bundle exec rspec spec/system/
docker-compose exec web bundle exec rspec spec/models/

# With documentation format
docker-compose exec web bundle exec rspec --format documentation
```

### Code Quality

**Rubocop**:
```bash
# Run all cops
docker-compose exec web bundle exec rubocop

# Auto-fix
docker-compose exec web bundle exec rubocop -a

# Specific file
docker-compose exec web bundle exec rubocop app/models/user.rb
```

**Configuration**: `.rubocop.yml`
- Disabled cops: `Style/FrozenStringLiteralComment`, `Style/Documentation`
- Custom RSpec config: Max nested groups = 8
- Excluded paths: `bin/`, `db/`, `vendor/`, `config/environments/`

---

## Common Tasks

### Creating a New Feature

1. **Plan the feature**:
   - Identify required models/tables
   - Design routes
   - Sketch views

2. **Generate migration** (if needed):
   ```bash
   docker-compose exec web bundle exec rails g migration AddFieldToModel field:type
   docker-compose exec web bundle exec rails db:migrate
   ```

3. **Create/modify model**:
   - Add validations
   - Define associations
   - Add business logic methods

4. **Add routes**:
   - Edit `config/routes.rb`
   - Keep RESTful when possible

5. **Create controller**:
   - Define actions
   - Use before_actions
   - Keep actions thin

6. **Create views**:
   - Use Tailwind/DaisyUI
   - Extract partials
   - Add I18n keys

7. **Add translations**:
   - Model attributes: `config/locales/activerecord/ja.yml`
   - Views: `config/locales/view/{controller}/ja.yml`

8. **Write tests**:
   - Factory for new model
   - Model specs
   - System specs for user flows

9. **Run tests and linter**:
   ```bash
   docker-compose exec web bundle exec rspec
   docker-compose exec web bundle exec rubocop
   ```

### Modifying Existing Features

1. **Read existing code first**:
   - Check model for validations/associations
   - Review controller logic
   - Examine views for UI patterns

2. **Understand dependencies**:
   - Check where model is used (search codebase)
   - Review related tests
   - Check for query objects

3. **Make changes**:
   - Update model (validations, methods)
   - Update controller (actions, params)
   - Update views (templates, partials)
   - Update I18n (translations)

4. **Update tests**:
   - Modify existing tests
   - Add new test cases
   - Ensure coverage

5. **Run full test suite**:
   ```bash
   docker-compose exec web bundle exec rspec
   ```

### Adding a New Query

1. **Create query class**:
   ```ruby
   # app/queries/my_new_query.rb
   class MyNewQuery < Query
     def initialize(user)
       @user = user
     end

     def call
       # Return query result
     end
   end
   ```

2. **Use in controller**:
   ```ruby
   @data = MyNewQuery.call(current_user)
   ```

3. **Format for charts** (if needed):
   ```ruby
   # In helper
   def format_data(data)
     data.map { |item| [item.date.strftime('%Y-%-m-%-d'), item.value] }
   end
   ```

### Debugging

**In Code**:
```ruby
# Add breakpoint
binding.pry

# Or use debug
debugger
```

**Rails Console**:
```bash
docker-compose exec web bundle exec rails console

# Explore data
User.count
Competition.last
```

**Logs**:
```bash
# View logs
docker-compose logs -f web

# Rails logs
tail -f log/development.log
```

**Better Errors**:
- Automatically enabled in development
- Visit error page for interactive console

---

## Important Notes for AI Assistants

### What to Always Do

1. **Read Before Modifying**:
   - Always use `Read` tool to examine files before editing
   - Understand existing patterns before adding new code
   - Check related files (model, controller, view, tests)

2. **Follow Existing Patterns**:
   - Use query objects for complex queries
   - Use form objects for multi-step forms
   - Use helpers for view logic
   - Use I18n for all user-facing text

3. **Maintain Consistency**:
   - Follow naming conventions
   - Match code style of existing files
   - Use Tailwind/DaisyUI classes consistently
   - Keep Japanese translations updated

4. **Test Everything**:
   - Write tests for new features
   - Update tests for modified features
   - Run full test suite before finishing
   - Check Rubocop compliance

5. **Document Intent**:
   - Add comments for complex logic
   - Update this CLAUDE.md if patterns change
   - Keep commit messages clear

### What to Never Do

1. **Don't Skip Tests**:
   - Never ship features without tests
   - Don't ignore failing tests
   - Don't disable tests without good reason

2. **Don't Break Patterns**:
   - Don't create controllers without corresponding views
   - Don't bypass the step-form pattern for competition records
   - Don't add business logic to views
   - Don't put complex queries directly in controllers

3. **Don't Ignore I18n**:
   - Don't hardcode Japanese text in views
   - Don't leave English text in user-facing areas
   - Don't forget to translate new models/attributes

4. **Don't Bypass Validations**:
   - Don't use `save(validate: false)` unless absolutely necessary
   - Don't skip authentication checks
   - Don't allow guest users to mutate data

5. **Don't Modify Calculated Fields Directly**:
   - IPF GL points should only be calculated, never manually set
   - Best lift values are derived from attempts, not input
   - Total lifted weight is calculated, not stored from input

### Critical Files (Be Careful)

These files are central to the application. Changes require extra care:

1. **`app/models/competition_result.rb`**: IPF GL calculation logic
2. **`app/controllers/record/comments_controller.rb`**: Final step persistence logic
3. **`config/initializers/sorcery.rb`**: Authentication configuration
4. **`config/routes.rb`**: Application routing
5. **`db/schema.rb`**: Database structure (modify via migrations only)
6. **`tailwind.config.js`**: Theme configuration
7. **`.github/workflows/rubyonrails.yml`**: CI/CD pipeline

### Understanding the Step-Form Flow

When working with competition records, understand the complete flow:

1. User navigates to `/competitions/:id/weigh_in/new`
2. Enters body weight → Stored in session
3. Redirected to `/competitions/:id/squat/new`
4. Enters squat attempts → Stored in session
5. Redirected to `/competitions/:id/bench_presse/new`  ⚠️ Note: "presse" not "press"
6. Enters bench press attempts → Stored in session
7. Redirected to `/competitions/:id/deadlift/new`
8. Enters deadlift attempts → Stored in session
9. Redirected to `/competitions/:id/comment/new`
10. Enters comment → Triggers database save of all data
11. Calculates best lifts, total, IPF GL points
12. Clears session data
13. Redirects to competition show page

**Edit Flow**: Similar but uses existing data to pre-populate forms.

### Working with Enums

All enums use integer storage with symbol keys:

```ruby
# CORRECT: Symbol keys
competition.competition_type = :official
competition.gearcategory_type = :raw

# ALSO CORRECT: Integer values
competition.competition_type = 0
competition.gearcategory_type = 0

# INCORRECT: String keys
competition.competition_type = 'official'  # Will fail
```

**Translation**:
```ruby
# Use enum_help provided method
competition.competition_type_i18n  # => '公式'

# Or use I18n directly
I18n.t("activerecord.enums.competition.competition_type.#{competition.competition_type}")
```

### Authentication Flow

**LINE OAuth**:
1. User clicks "LINEログイン"
2. Redirected to `/oauth/line`
3. Sorcery redirects to LINE
4. LINE redirects back to `/oauth/callback`
5. `OauthsController#callback` handles login/registration
6. User redirected to profile existence check
7. If no profile exists → redirect to profile creation
8. Otherwise → redirect to competitions index

**Guest Login**:
1. User clicks "ゲストログイン"
2. POST to `/guest_login`
3. `GuestSessionsController#create` finds/creates guest user
4. Auto-login and redirect to competitions index
5. Guest users see all features but cannot mutate data

### Query Object Selection Guide

When fetching data for charts, use the appropriate query class:

**Format**: `{Equipment}{Category}{Metric}Query`

**Equipment**:
- `Classic` = Raw (ノーギア)
- `Equipped` = Equipped (フルギア)

**Category**:
- `Powerlifting` = All three lifts
- `SingleBenchPress` = Bench press only

**Metric**:
- `Ipfglpoints` = IPF GL points over time
- `TotalLiftedWeight` = Total weight over time
- `LiftedWeight` = Individual lift weight over time

**Example Selection**:
- Want raw powerlifting total weights? → `ClassicPowerliftingTotalLiftedWeightQuery`
- Want equipped bench press IPF points? → `EquippedSingleBenchPressIpfglpointsQuery`

### IPF GL Points Calculation

**Never modify the formula or coefficients** unless you have official IPF documentation.

The current formula and coefficients are based on official IPF standards.

**If coefficients need updating**:
1. Verify with official IPF sources
2. Update `CompetitionResult::COEFFICIENTS`
3. Add comment with source/date of coefficients
4. Test calculations against known competition results

### Deployment Notes

**Production Environment**: Render

**CI/CD**:
- GitHub Actions runs on push/PR to `main`
- Tests must pass before merge
- Rubocop must pass before merge

**Environment Variables** (Production):
- `APP_DATABASE` - Database name
- `APP_DATABASE_USERNAME` - Database username
- `APP_DATABASE_PASSWORD` - Database password
- LINE credentials stored in Rails encrypted credentials
- LineBot credentials stored in Rails encrypted credentials

**Credentials Management**:
```bash
# Edit credentials
EDITOR=vim bundle exec rails credentials:edit

# Edit environment-specific credentials
EDITOR=vim bundle exec rails credentials:edit --environment production
```

### Performance Considerations

1. **N+1 Queries**: Use `includes` or `joins` for associations
   ```ruby
   # BAD
   competitions.each { |c| c.competition_record.competition_result }

   # GOOD
   competitions.includes(competition_record: :competition_result)
   ```

2. **Query Objects**: Already optimized with proper joins

3. **Chart Data**: Pre-format data in controller/helper, not in view

4. **Database Indexes**: Check `schema.rb` for indexed columns

### Troubleshooting Common Issues

**Issue**: Asset not found
- **Solution**: Run `yarn build` or `yarn build:css`

**Issue**: Database connection error
- **Solution**: Ensure Docker `db` service is running
- **Solution**: Check `config/database.yml` credentials

**Issue**: LINE OAuth failing
- **Solution**: Check credentials: `bundle exec rails credentials:edit`
- **Solution**: Verify callback URL matches LINE Developer Console

**Issue**: Tests failing in CI but passing locally
- **Solution**: Check `spec/support/capybara.rb` for environment-specific config
- **Solution**: Ensure database is properly seeded in CI

**Issue**: Guest user can create/edit/delete
- **Solution**: Check `ApplicationController#restrict_guest_user_actions` is applied
- **Solution**: Verify `before_action :restrict_guest_user_actions` is not skipped

**Issue**: IPF GL points calculation incorrect
- **Solution**: Verify body weight is present in `CompetitionRecord`
- **Solution**: Check gender in user's `Profile`
- **Solution**: Verify correct equipment type (`raw` vs `equipped`)
- **Solution**: Ensure category is correctly identified

---

## Quick Reference

### Essential Commands

```bash
# Development
docker-compose up -d                          # Start services
docker-compose exec web rails c               # Rails console
docker-compose exec web rails routes          # View routes
docker-compose logs -f web                    # View logs

# Testing
docker-compose exec web rspec                 # Run all tests
docker-compose exec web rspec spec/models/    # Run model tests
docker-compose exec web rspec spec/system/    # Run system tests

# Code Quality
docker-compose exec web rubocop               # Run linter
docker-compose exec web rubocop -a            # Auto-fix issues

# Database
docker-compose exec web rails db:migrate      # Run migrations
docker-compose exec web rails db:rollback     # Rollback last migration
docker-compose exec web rails db:reset        # Reset database

# Assets
yarn build                                    # Build JavaScript
yarn build:css                                # Build Tailwind CSS
```

### Key URLs (Development)

- Application: http://localhost:3000
- Letter Opener (Email): http://localhost:3000/letter_opener
- Database (PostgreSQL): localhost:5432
- Selenium Grid: http://localhost:4444

### Important Model Methods

```ruby
# User
user.guest?                                   # Check if guest user
user.profile                                  # Get user profile
user.competitions                             # Get user competitions

# Competition
competition.competition_record                # Get attempt data
competition.competition_result                # Get calculated results
competition.competition_type_i18n             # Get translated type

# CompetitionRecord
record.result_save                            # Save and calculate results
record.best_squat                             # Get best squat attempt
record.best_benchpress                        # Get best bench attempt
record.best_deadlift                          # Get best deadlift attempt
```

### Key Helper Methods

```ruby
# ApplicationHelper
flash_background_color(type)                  # Get flash message CSS class

# ChartsHelper
format_dates_and_weights(data)                # Format chart data
```

---

## Changelog

| Date | Changes |
|------|---------|
| 2025-11-26 | Initial CLAUDE.md creation |

---

## Additional Resources

- **Production URL**: https://www.powerlifterslog.com/
- **GitHub Repository**: [Current repository]
- **Figma Design**: https://www.figma.com/file/pGxlFmkWvjxv384P6Ymi9x/Good-Lifter-log
- **IPF Official**: Check official IPF website for formula updates

---

## Contact & Support

For questions about this documentation or the codebase:
1. Review this CLAUDE.md file
2. Check the README.md for project overview
3. Examine existing code for patterns
4. Consult Rails/Ruby documentation
5. Check gem documentation for specific libraries

Remember: This project serves the powerlifting community. Changes should enhance the user experience for athletes tracking their competition progress. Always consider the end user when making decisions.
