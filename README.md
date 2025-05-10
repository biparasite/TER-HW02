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

```bash
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
```

variables.tf

```bash
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

```bash
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

```bash
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

## Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores = 2, memory = 2, core*fraction = 20. Объявите её переменные с префиксом vm_db* в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

### Ответ

![task3](https://github.com/biparasite/TER-HW02/blob/main/task_3.1.png "task3")

---

## Задание 4

Объявите в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
Примените изменения.
В качестве решения приложите вывод значений ip-адресов команды terraform output.

### Ответ

![task4](https://github.com/biparasite/TER-HW02/blob/main/task_4.1.png "task4")

---

## Задание 5

1. В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

### Ответ

```bash
locals {
    web_name = "${var.vpc_name}-${var.vm_web_image}"
    db_name  = "${var.vm_db_vpc_name}-${var.vm_web_image}"
}
```

<details> <summary>Outputs</summary>

![task5](https://github.com/biparasite/TER-HW02/blob/main/task_5.1.png "task5")

```
Outputs:

vm_db = [
  "netology-develop-platform-db-ubuntu-2004-lts",
  "158.160.91.182",
  "epdcunigffu1qbrhjspk.auto.internal",
]
vm_web = [
  "develop-ubuntu-2004-lts",
  "130.193.36.157",
  "fhm9ltnbs4gkgnupacnp.auto.internal",
]
```

 </details>

---

## Задание 6

Вместо использования трёх переменных "..\_cores","..\_memory","..\_core_fraction" в блоке resources {...}, объедините их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map(object).

```
пример из terraform.tfvars:
vms_resources = {
  web={
    cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
    ...
  },
  db= {
    cores=2
    memory=4
    core_fraction=20
    hdd_size=10
    hdd_type="network-ssd"
    ...
  }
}
```

2. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.

```
пример из terraform.tfvars:
metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
}
```

3. Найдите и закоментируйте все, более не используемые переменные проекта.

4. Проверьте terraform plan. Изменений быть не должно.

### Ответ

![task6](https://github.com/biparasite/TER-HW02/blob/main/task_6.1.png "task6")
