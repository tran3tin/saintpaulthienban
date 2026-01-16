/**
 * Query Adapter - Converts MySQL queries to PostgreSQL
 * Handles placeholder conversion and basic syntax differences
 */

/**
 * Convert MySQL placeholders (?) to PostgreSQL numbered placeholders ($1, $2, ...)
 */
function convertPlaceholders(query, params = []) {
  if (!params || params.length === 0) {
    return { query, params };
  }

  let index = 1;
  const convertedQuery = query.replace(/\?/g, () => `$${index++}`);

  return {
    query: convertedQuery,
    params,
  };
}

/**
 * Execute query with automatic placeholder conversion
 */
async function executeQuery(pool, query, params = []) {
  const { query: convertedQuery, params: convertedParams } =
    convertPlaceholders(query, params);

  const client = await pool.connect();
  try {
    const result = await client.query(convertedQuery, convertedParams);
    return result.rows;
  } finally {
    client.release();
  }
}

/**
 * Execute single query and return first row
 */
async function executeQueryOne(pool, query, params = []) {
  const rows = await executeQuery(pool, query, params);
  return rows[0] || null;
}

/**
 * Execute query without params (for migrations, DDL statements)
 */
async function executeRawQuery(pool, query) {
  const client = await pool.connect();
  try {
    const result = await client.query(query);
    return result;
  } finally {
    client.release();
  }
}

module.exports = {
  convertPlaceholders,
  executeQuery,
  executeQueryOne,
  executeRawQuery,
};
