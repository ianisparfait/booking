<?php

namespace App\Controller;

use App\Entity\Table;
use App\Form\TableType;
use App\Service\EntityService;
use App\Service\JsonService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class TableController extends AbstractController
{
    private EntityManagerInterface $em;
    private EntityService $es;
    private JsonService $js;

    public function __construct(EntityManagerInterface $em, EntityService $es, JsonService $js) {
        $this->em = $em;
        $this->es = $es;
        $this->js = $js;
    }

    #[Route("/tables", name: "create_table", methods: ["POST"])]
    public function create(Request $request): JsonResponse
    {
        $entity = new Table();
        $form = $this->createForm(TableType::class, $entity);

        $data = json_decode($request->getContent(), true);

        if (!$this->es->checkFields($data, "Table")) {
            return new JsonResponse(["error" => "Champs manquant"], Response::HTTP_BAD_REQUEST);
        }

        return $this->es->CreateOrUpdate($form, $entity, $data, "Table");
    }

    #[Route("/tables/{id}", name: "delete_table", methods: ["DELETE"])]
    public function delete(int $id): JsonResponse
    {
        $entity = $this->em->getRepository(Table::class)->find($id);

        if (!$entity) {
            return new JsonResponse(["error" => "Donnée non trouvée"], Response::HTTP_NOT_FOUND);
        }

        $this->em->remove($entity);
        $this->em->flush();

        return new JsonResponse(["message" => "Supprimée avec succès"]);
    }


    #[Route("/tables", name: "list_tables", methods: ["GET"])]
    public function list(): JsonResponse
    {
        $entities = $this->em->getRepository(Table::class)->findAll();

        $entities = $this->js->arrayToJson($entities, "Table");

        return new JsonResponse($entities, 200);
    }

    #[Route("/tables/{id}", name: "update_table", methods: ["PUT"])]
    public function update(Request $request, int $id): JsonResponse
    {
        $entity = $this->em->getRepository(Table::class)->find($id);
        if (!$entity) {
            return new JsonResponse(["error" => "Donnée non trouvée"], Response::HTTP_NOT_FOUND);
        }

        $data = json_decode($request->getContent(), true);
        if (!$this->es->checkFields($data, "Table")) {
            return new JsonResponse(["error" => "Champs manquant"], Response::HTTP_BAD_REQUEST);
        }

        $form = $this->createForm(TableType::class, $entity);
        return $this->es->CreateOrUpdate($form, $entity, $data, "Table");
    }
}
