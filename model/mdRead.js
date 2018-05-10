
const fs = require("fs");
const path = require("path");
const { promisify } = require("util");
const iconv = require("iconv-lite");
// const readFilePromise = promisify(fs.readFile);
const mdPath = path.join(__dirname, "../MD/");
const dirs = fs.readdirSync(mdPath);
console.log(dirs);

function readFile(path, opts) {
  return new Promise((resolve, reject) => {
    let chunks = [];
    let size = 0;
    const readStream = fs.createReadStream(path, opts); // 宽字节字符串被截断

    readStream.on("data", chunk => {
      chunks.push(chunk);
      size += chunk.length;
    });
    readStream.on("end", () => {
      const buf = Buffer.concat(chunks, size);
      const str = iconv.decode(buf, "utf8");
      resolve(str);
    });
    readStream.on("error", error => {
      reject(error);
    });
  });
}
readFile(path.join(mdPath, dirs[5]))
  .then(e => console.log(e))
