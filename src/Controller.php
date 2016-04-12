<?php
namespace Nathejk\Tilmelding;

use Symfony\Component\HttpFoundation\Request;

class Controller
{
    public function indexAction(Application $app, Request $request)
    {
        $text = file_get_contents(__DIR__ . '/../README.md');
        return \Michelf\MarkdownExtra::defaultTransform($text);
    }

    public function proxyAction(Application $app, Request $request)
    {

//die($request->getRequestUri());
        $stream = function () use ($request) {
            $url = 'http://172.17.42.1:8002' . $request->getRequestUri();
            $ch = curl_init($url);
            curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
            if ($request->isMethod(Request::METHOD_POST)) {
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($request->request->all()));
            }
            curl_exec($ch);
            curl_close($ch);
        };
        return $app->stream($stream);
    }
}
