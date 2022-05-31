const getRandomInt = (min, max) => {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

const compareObj = (obj1, obj2) => {
    return JSON.stringify(obj1) === JSON.stringify(obj2);
};

module.exports = { getRandomInt, compareObj };
