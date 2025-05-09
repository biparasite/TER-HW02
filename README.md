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
