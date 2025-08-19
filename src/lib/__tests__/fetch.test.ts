/* eslint-disable import/no-unresolved */
import { expect } from '@jest/globals';
import { request } from '../fetch';

test('request handles empty JSON response', async () => {
  const originalFetch = global.fetch;
  // Mock fetch to return an empty body which would normally cause res.json() to throw
  global.fetch = jest.fn(() => Promise.resolve(new Response(null, { status: 204 }))) as any;

  const result = await request('GET', '/test');

  expect(result).toEqual({
    ok: true,
    status: 204,
    data: null,
    error: undefined,
  });

  global.fetch = originalFetch;
});
