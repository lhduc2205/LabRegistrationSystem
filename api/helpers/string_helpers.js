const capitalizeFirstLetter = (string) => {
    return string.charAt(0).toUpperCase() + string.slice(1);
};

const capitalizeFirstEachLetter = (phrase) => {
    return phrase
        .toLowerCase()
        .split(' ')
        .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
};

module.exports = { capitalizeFirstLetter, capitalizeFirstEachLetter };
