# 🧪 Regression Testing Checklist for v1.0.0

**Target Branch:** `regression`  
**Merge Source:** `staging`  
**Date:** 2025-07-31  
**Tester:** Mr. Deepana Welivitage

---

## 🔍 General Goals

- Ensure no existing functionality is broken
- Validate system-wide behavior
- Confirm stable, release-ready build
- Final testing before `main` merge and tagging

---

## ✅ Full System Regression Test

| Module              | Test Case Description                   | Status |
|---------------------|-----------------------------------------|--------|
| Login               | Valid & invalid login flow              | ✅ Pass |
| Logout              | Logout clears session properly          | ✅ Pass |
| Customer Management | Full CRUD + UI feedback                 | ✅ Pass |
| Item Management     | Full CRUD + price and category handling | ✅ Pass |
| Billing Module      | Create multiple bills with mixed items  | ✅ Pass |
| Billing Module      | Calculate correct totals                | ✅ Pass |
| Help Page           | Loads with instructions for each module | ✅ Pass |
| Navigation          | Links work across dashboard and sidebar | ✅ Pass |
| UI Theme            | Dark theme applied globally             | ✅ Pass |

---

## 🧪 JUnit Testing

| Task                                          | Status                   |
|-----------------------------------------------|--------------------------|
| All unit tests pass (`mvn test`)              | ✅ Pass                   |
| No skipped or ignored test cases              | ✅ Pass                   |
| Test logs clean (no unexpected output/errors) | ⚠️ Warning – Pending Fix |

---

## 🛡 Security & Routing

| Test Case                                            | Status |
|------------------------------------------------------|--------|
| Protected views are not accessible without login     | ✅ Pass |
| URLs under `WEB-INF/views` cannot be opened directly | ✅ Pass |
| Session expiration handled gracefully                | ✅ Pass |

---

## 🧼 Release Readiness

| Task                                         | Status      |
|----------------------------------------------|-------------|
| `pom.xml` version is `1.0.0`                 | ✅ Confirmed |
| `CHANGELOG.md` matches implemented modules   | ✅ Confirmed |
| UI content free of typos or placeholder text | ✅ Confirmed |
| Application is stable on final deploy test   | ✅ Confirmed |

---

## 🗒 Notes

- Some `System.out.println` debugging logs remain and are acknowledged. These will be removed or refactored in a future release to improve code cleanliness and logging practices.

---

### 🚀 Ready to Merge into `main`: ✅ Yes
