<?php

namespace App\Controller;

use App\Entity\Booking;
use App\Service\EntityService;
use App\Service\JsonService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

final class BookingController extends AbstractController
{
    private EntityManagerInterface $em;
    private EntityService $es;
    private JsonService $js;

    public function __construct(EntityManagerInterface $em, EntityService $es, JsonService $js) {
        $this->em = $em;
        $this->es = $es;
        $this->js = $js;
    }

    #[Route("/bookings", name: "list_bookings", methods: ["GET"])]
    public function list(): JsonResponse
    {
        $entities = $this->em->getRepository(Booking::class)->findAll();

        $entities = $this->js->arrayToJson($entities, "Booking");

        return new JsonResponse($entities, 200);
    }
}
