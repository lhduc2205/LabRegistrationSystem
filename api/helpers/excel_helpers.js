const drawBorder = (worksheet, index) => {
    [
        `A${index}`,
        `B${index}`,
        `C${index}`,
        `D${index}`,
        `E${index}`,
        `F${index}`,
        `G${index}`,
        `H${index}`,
        `I${index}`,
        `J${index}`,
        `K${index}`,
        `L${index}`,
        `M${index}`,
        `N${index}`,
        `O${index}`,
        `P${index}`,
        `Q${index}`,
        `R${index}`,
        `S${index}`,
        `T${index}`,
    ].map((key) => {
        worksheet.getCell(key).border = {
            top: { style: 'thin' },
            left: { style: 'thin' },
            bottom: { style: 'thin' },
            right: { style: 'thin' },
        };
        worksheet.getCell(key).alignment = {
            vertical: 'top',
            horizontal: 'center',
            wrapText: true,
        };
    });
};

const setBackground = (worksheet, index, background) => {
    [
        `H${index}`,
        `I${index}`,
        `J${index}`,
        `K${index}`,
        `L${index}`,
        `M${index}`,
        `N${index}`,
        `O${index}`,
        `P${index}`,
        `Q${index}`,
    ].map((key) => {
        worksheet.getCell(key).fill = {
            type: 'pattern',
            pattern: 'solid',
            fgColor: { argb: background },
        };
    });
};

const mergeEachGroup = (worksheet, startRow, endRow, stt, soLuong) => {
    worksheet.mergeCells(`H${startRow}:H${endRow}`);
    worksheet.mergeCells(`I${startRow}:I${endRow}`);
    worksheet.getCell(`H${startRow}`).value = stt;
    worksheet.getCell(`I${startRow}`).value = soLuong;
};

const mergeCells = (worksheet, curRow, endRow) => {
    worksheet.mergeCells(`A${curRow}:A${endRow}`);
    worksheet.mergeCells(`B${curRow}:B${endRow}`);
    worksheet.mergeCells(`C${curRow}:C${endRow}`);
    worksheet.mergeCells(`D${curRow}:D${endRow}`);
    worksheet.mergeCells(`E${curRow}:E${endRow}`);
    worksheet.mergeCells(`F${curRow}:F${endRow}`);
    worksheet.mergeCells(`G${curRow}:G${endRow}`);
    // worksheet.mergeCells(`H${curRow}:H${endRow}`);
    // console.log(`A${curRow}:A${endRow}`);
};
module.exports = { drawBorder, setBackground, mergeCells, mergeEachGroup };
