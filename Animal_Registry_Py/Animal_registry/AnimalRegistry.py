import csv

from Animal_registry import Counter


class AnimalRegistry:
    def __init__(self):
        self.animals = []
        self.counter = Counter()

    def add_animal(self, animal):
        self.animals.append(animal)
        self.counter.add()

    def get_animals(self):
        return self.animals

    def save_to_csv(self):
        with open('animals.csv', 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Name", "Type", "Commands"])
            for animal in self.animals:
                writer.writerow([animal.name, type(animal).__name__, ', '.join(animal.get_commands())])