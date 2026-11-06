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
| SSH 파이프라이닝 성능 테스트 | `perf.yml` |
| Jenkins 파이프라인 (파라미터 · ansible-lint 게이트 · fail-closed 배포) | `Jenkinsfile`, `jenkins-agent/Dockerfile`, `.ansible-lint` |

`attack-demo` 브랜치에는 같은 날 해 본 공격 실습 두 가지가 있습니다: Jenkins 자격 증명 파일(vault 비밀번호)을 마스킹을 피해 출력해 보기, 문자열 파라미터를 Groovy 큰따옴표로 보간할 때의 명령 주입과 셸 작은따옴표 + `env`로 넘기는 안전한 방식 비교. 실제 비밀번호는 들어 있지 않습니다.

실습 노드는 로컬 Docker 컨테이너(`127.0.0.1:2221`~`2225`)였습니다.
