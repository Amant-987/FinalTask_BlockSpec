from Animal_registry import Animal, Pet, BeastOfBurden, Dog, Cat, Hamster, Donkey, Horse, Camel, Counter, AnimalRegistry

def main():
    registry = AnimalRegistry()
    while True:
        print("1. Завести новое животное")
        print("2. Увидеть список команд, которое выполняет животное")
        print("3. Обучить животное новым командам")
        print("4. Просмотреть введенных животных и их характеристики")
        print("5. Сохранить в CSV")
        print("6. Выход")
        choice = input("Выберите действие: ")
        if choice == "1":
            animal_type = input("Введите тип животного (Dog, Cat, Hamster, Donkey, Horse, Camel): ")
            animal_name = input("Введите имя животного: ")
            if animal_type == "Dog":
                animal = Dog(animal_name)
            elif animal_type == "Cat":
                animal = Cat(animal_name)
            elif animal_type == "Hamster":
                animal = Hamster(animal_name)
            elif animal_type == "Donkey":
                animal = Donkey(animal_name)
            elif animal_type == "Horse":
                animal = Horse(animal_name)
            elif animal_type == "Camel":
                animal = Camel(animal_name)
            else:
                print("Неверный тип животного.")
                continue
            registry.add_animal(animal)
            print(f"Животное {animal_type} с именем {animal_name} добавлено.")
        elif choice == "2":
            for i, animal in enumerate(registry.get_animals(), start=1):
                print(f"{i}. {animal.name} ({type(animal).__name__}): {animal.get_commands()}")
        elif choice == "3":
            animal_index = int(input("Введите номер животного: ")) - 1
            command = input("Введите команду: ")
            registry.get_animals()[animal_index].add_command(command)
            print(f"Команда {command} добавлена для животного {registry.get_animals()[animal_index].name}.")
        elif choice == "4":
            for i, animal in enumerate(registry.get_animals(), start=1):
                print(f"{i}. {animal.name} ({type(animal).__name__}): {animal.get_commands()}")
        elif choice == "5":
            registry.save_to_csv()
            print("Животные сохранены в файл CSV.")
        elif choice == "6":
            break
        else:
            print("Неверный выбор.")


if __name__ == "__main__":
    main()