# Домашнее задание к занятию " `Основы Terraform. Yandex Cloud` " - `Сулименков Алексей`

---

## Задание 1

В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.8.4

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Подключитесь к консоли ВМ через ssh и выполните команду ` curl ifconfig.me`.
   Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: `"ssh ubuntu@vm_ip_address"`. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: `eval $(ssh-agent) && ssh-add` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
6. Ответьте, как в процессе обучения могут пригодиться параметры `preemptible = true` и `core_fraction=5` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

### Ответ

1. скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес

<details> <summary>Виртуальная машина</summary>

![task1](https://github.com/biparasite/TER-HW02/blob/main/task_1.1.png "task1")

 </details>

2. скриншот консоли, curl должен отобразить тот же внешний ip-адрес

<details> <summary>Curl</summary>

![task1](https://github.com/biparasite/TER-HW02/blob/main/task_1.2.png "task1")

 </details>

3. ответы на вопросы:

- Отсутствует standart-v4 (Platform "standart-v4" not found), неправильно указано число ядер. Доступные конфигурации https://yandex.cloud/ru/docs/compute/concepts/performance-levels#available-configurations
- `preemptible = true` Прерываемые виртуальные машины, т.е. будут оставновлены, максимум через 24ч, что поможет съэкономить денег, если не сделать terraform destroy. https://yandex.cloud/ru/docs/compute/concepts/preemptible-vm
- `core_fraction` - от уровня производительность зависит цена VM, чем ниже, тем дешевле.

---

## Задание 2

Замените все хардкод-значения для ресурсов yandex*compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web* . Пример: vm_web_name.
Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
Проверьте terraform plan. Изменений быть не должно.

### Ответ

Для `yandex_compute_image`:

<details> <summary>yandex_compute_image</summary>

main.tf

```json
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
```

variables.tf

```json
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM OS image"
}
```

 </details>

Для `yandex_compute_instance`

<details> <summary>yandex_compute_instance</summary>

main.tf

```json
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vm_web_core
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
```

variables.tf

```json
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "VM platform"
}

variable "vm_web_core" {
  type        = number
  default     = "2"
  description = "VM platform cpu"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "VM platform memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "5"
  description = "VM platform core_fraction"
```

 </details>

---
