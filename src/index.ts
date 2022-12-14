import { join } from 'path';
import * as express from 'express';
import * as morgan from 'morgan';

const app = express();
const port = 3123;

app.use(morgan('combined'));

app.use('/g', express.static(join(__dirname, 'static')));

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.listen(port, () => {
  console.log(`Server listening on port: ${port}`);
});