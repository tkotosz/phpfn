<?php

$stdin = fopen('php://stdin', 'r');
$line = trim(fgets(STDIN));
$data = json_decode($line, true);

echo json_encode(['message' => 'Hello ' . ($data['name'] ?? 'World')]) . PHP_EOL;
