<?php
namespace Nathejk\Tilmelding;

class Application extends \Silex\Application
{
    public function boot()
    {
        $this['time'] = time();

        $this->registerRoutes();
        $this->registerServices();
        parent::boot();
    }

    protected function registerRoutes()
    {
        $this->match('/', Controller::class . '::proxyAction');
        $this->post('/verify', Controller::class . '::proxyAction');
        $this->get('/tak', Controller::class . '::proxyAction');
        $this->get('/liga', Controller::class . '::proxyAction');

        $this->match('/senior/{id}', Controller::class . '::proxyAction');
        $this->match('/spejder/{id}', Controller::class . '::proxyAction');
        
        $this->get('/upload/{key}', Controller::class . '::proxyAction');
        $this->get('/photo/{key}', Controller::class . '::proxyAction');

        $this->get('/kort', Controller::class . '::proxyAction');
        $this->get('/kort/{nr}', Controller::class . '::proxyAction');
        $this->get('/diplom', Controller::class . '::proxyAction');
        $this->get('/diplom/{nr}', Controller::class . '::proxyAction');
    }

    protected function registerServices()
    {
    }
}
