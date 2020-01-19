import { Response, Request } from 'express';
import RoundRepository from '../repository/RoundRepository';

export default class RoundController {
  private roundRepository: RoundRepository;

  constructor() {
    this.roundRepository = new RoundRepository();
  }

  public async all(req: Request, res: Response) {
    try {
      res.send({ rounds: await this.roundRepository.all(req.params.competition, req.params.year) });
    } catch (error) {
      res.status(404).send({ error: true });
    }
  }

  public async get(req: Request, res: Response) {
    try {
      res.send({ round: await this.roundRepository.get(req.params.round) });
    } catch (error) {
      res.status(404).send({ error: true });
    }
  }
}
