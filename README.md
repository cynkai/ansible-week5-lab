# ansible-week5-lab

> **📦 보관됨 (2026-10)** — 클클 10기 Jenkins & Ansible 스터디(시즌 1)가 끝나 더 이상 관리하지 않는 읽기 전용 레포입니다.

Ansible 5주차 실습: roles, vault, orchestration, rolling/blue-green 배포를 다루고 Jenkins 파이프라인으로 묶었습니다.
이후 Jenkins 실습은 [jenkins-ansible-cicd](https://github.com/cynkai/jenkins-ansible-cicd)에서 이어집니다.

| 주제 | 파일 |
|---|---|
| Roles (common · webapp · haproxy) | `roles/`, `site.yml` |
| Vault | `group_vars/web/vault.yml`, `vault_test.yml`, `vault_pass_env.sh` |
| import / include, 태그·라벨 | `import_test.yml`, `include_*.yml`, `label_*.yml` |
| Orchestration (순서·실패 처리) | `orch_*.yml` |
| Rolling / 롤백 | `rolling.yml`, `rolling_rb.yml` |
| Blue-Green 전환 | `bluegreen.yml`, `bg_switch.yml` |
| Jenkins 파이프라인 (파라미터 · ansible-lint 게이트 · fail-closed 배포) | `Jenkinsfile`, `jenkins-agent/Dockerfile`, `.ansible-lint` |

실습 노드는 로컬 Docker 컨테이너(`127.0.0.1:2221`~`2225`)였습니다.
