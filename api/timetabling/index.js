const Data = require('./data');
const Population = require('./population');
const GeneticAlgorithm = require('./genetic_algorithm');

const SemesterService = require('../services/semester_academic_service');

const POPULATION_SIZE = 9;
const NUMB_OF_ELITE_SCHEDULES = 1;
const TOURNAMENT_SELECTION_SIZE = 3;
const MUTATION_RATE = 0.1;

const scheduling = async () => {
    const weekLength = await getWeekLength();

    var data = new Data();
    await data.getData();

    var result = [];
    var conflict = [];

    for (let i = 1; i <= 16; i++) {
        var generationNumber = 0;
        var _data = Object.assign(new Data(), data);
        _data.course = data.course.filter((element) => element.tuan_id == i);

        if (_data.course.length == 0) {
            continue;
        }

        var population = new Population(POPULATION_SIZE, _data);
        population.get_schedules().sort((a, b) => {
            return b.getFitness() - a.getFitness();
        });

        const geneticAlgorithm = new GeneticAlgorithm(
            _data,
            POPULATION_SIZE,
            NUMB_OF_ELITE_SCHEDULES,
            MUTATION_RATE,
            TOURNAMENT_SELECTION_SIZE,
        );

        while (
            population.schedules[0].fitness != 1.0 &&
            generationNumber < 5000
        ) {
            generationNumber++;

            console.log(`\n> Generation # ${generationNumber} - WEEK ${i}`);
            population = geneticAlgorithm.evolve(population);
            population.get_schedules().sort((a, b) => {
                return b.getFitness() - a.getFitness();
            });
        }
        result.push(...population.get_schedules()[0].classes);
        conflict.push(...population.get_schedules()[0].conflict);
    }

    // conflict = conflict.filter((e) => e.data.length != 0);

    // conflit.map(e => console.log(e));

    return { conflict: conflict, result: result };
};

const getWeekLength = async () => {
    var format = require('date-format');
    const semester = await SemesterService.getByDate(
        format.asString('MM-dd-yyyy', new Date()),
    );
    return semester.so_tuan;
};

module.exports = { scheduling };
