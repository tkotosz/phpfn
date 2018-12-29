<?php

require('vendor/autoload.php');

$loop = React\EventLoop\Factory::create();

$server = new React\Http\Server(function (Psr\Http\Message\ServerRequestInterface $request) {
    $data = json_decode($request->getBody()->getContents(), true);

    return new React\Http\Response(
        200,
        ['Content-Type' => 'application/json'],
        json_encode(['message' => 'Hello ' . ($data['name'] ?? 'World')]) . PHP_EOL
    );
});

$socket = new React\Socket\UnixServer(str_replace('unix:', '', getenv('FN_LISTENER')), $loop);
$server->listen($socket);

$loop->run();
