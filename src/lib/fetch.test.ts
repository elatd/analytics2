import { request } from './fetch';

describe('request', () => {
  it('handles empty response body', async () => {
    const mockFetch = jest.fn().mockResolvedValue(new Response(null, { status: 204 }));
    (global as any).fetch = mockFetch;

    await expect(request('GET', '/test')).resolves.toEqual({
      ok: true,
      status: 204,
      data: undefined,
      error: undefined,
    });
  });
});
