const { getRandomInt } = require('../helpers');
const Population = require('./population');
const Schedule = require('./schedule');

class GeneticAlgorithm {
    constructor(
        data,
        population_size,
        numb_of_elite_schedules,
        mutate_rate,
        tournament_selection_size,
    ) {
        this.data = data;
        this.population_size = population_size;
        this.numb_of_elite_schedules = numb_of_elite_schedules;
        this.mutate_rate = mutate_rate;
        this.tournament_selection_size = tournament_selection_size;
    }

    evolve(population) {
        return this.mutate_population(this.crossover_population(population));
    }

    crossover_population(pop) {
        var crossover_pop = new Population(0, this.data);

        for (let i = 0; i < this.numb_of_elite_schedules; i++)
            crossover_pop.get_schedules().push(pop.schedules[i]);

        var i = this.numb_of_elite_schedules;

        while (i < this.population_size) {
            const schedule1 =
                this.select_tournament_population(pop).get_schedules()[0];
            const schedule2 =
                this.select_tournament_population(pop).get_schedules()[0];
            crossover_pop
                .get_schedules()
                .push(this.crossover_schedule(schedule1, schedule2));
            i++;
        }

        return crossover_pop;
    }

    mutate_population(population) {
        for (
            let i = this.numb_of_elite_schedules;
            i < this.population_size;
            i++
        ) {
            this.mutate_schedule(population.get_schedules()[i]);
        }

        return population;
    }

    crossover_schedule(schedule1, schedule2) {
        var crossoverSchedule = new Schedule(this.data).initialize();

        for (let i = 0; i < crossoverSchedule.classes.length; i++) {
            if (Math.random() > 0.5) {
                crossoverSchedule.getClasses()[i] = schedule1.getClasses()[i];
            } else {
                crossoverSchedule.getClasses()[i] = schedule2.getClasses()[i];
            }
        }

        return crossoverSchedule;
    }

    mutate_schedule(mutateSchedule) {
        var schedule = new Schedule(this.data).initialize();

        for (let i = 0; i < mutateSchedule.getClasses().length; i++)
            if (this.mutate_rate > Math.random())
                mutateSchedule.getClasses()[i] = schedule.getClasses()[i];

        return mutateSchedule;
    }

    select_tournament_population(pop) {
        var tournament_pop = new Population(0, this.data);

        var i = 0;
        while (i < this.tournament_selection_size) {
            tournament_pop
                .get_schedules()
                .push(
                    pop.get_schedules()[
                        getRandomInt(0, this.population_size - 1)
                    ],
                );
            i++;
        }
        tournament_pop.schedules.sort((a, b) => {
            return a.getFitness() - b.getFitness();
        });

        return tournament_pop;
    }
}

module.exports = GeneticAlgorithm;
