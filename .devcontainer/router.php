<?php

$documentRoot = '/workspaces/admidio';
$requestPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
$filePath = $documentRoot . $requestPath;

// Match normal web server behaviour: redirect directory URLs to a trailing slash
// so relative links like "build.php" resolve inside that directory.
if ($requestPath !== '/' && is_dir($filePath) && !str_ends_with($requestPath, '/')) {
    $query = parse_url($_SERVER['REQUEST_URI'] ?? '', PHP_URL_QUERY);
    $location = $requestPath . '/';
    if ($query !== null && $query !== '') {
        $location .= '?' . $query;
    }

    header('Location: ' . $location, true, 301);
    exit;
}

// Let the PHP development server serve existing files and directory index files.
if (is_file($filePath) || is_dir($filePath)) {
    return false;
}

http_response_code(404);
echo 'Not Found';
